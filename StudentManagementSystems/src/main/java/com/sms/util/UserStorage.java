package com.sms.util;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

public class UserStorage {

    private static final String DIRECTORY_NAME =
            "student-management-system";

    private static final String CSV_FILE_NAME =
            "users.csv";

    private static final String OLD_FILE_NAME =
            "users.dat";

    /*
     * PBKDF2 configuration.
     */
    private static final int SALT_LENGTH = 16;

    private static final int HASH_LENGTH = 256;

    private static final int ITERATIONS = 120000;

    private static final SecureRandom RANDOM =
            new SecureRandom();


    /**
     * Get application data directory.
     */
    private static File getDataDirectory() {

        String userHome =
                System.getProperty("user.home");

        File directory =
                new File(userHome, DIRECTORY_NAME);

        if (!directory.exists()) {
            directory.mkdirs();
        }

        return directory;
    }


    /**
     * Get users.csv.
     */
    private static File getCsvFile() {

        return new File(
                getDataDirectory(),
                CSV_FILE_NAME
        );
    }


    /**
     * Get old users.dat.
     */
    private static File getOldDatFile() {

        return new File(
                getDataDirectory(),
                OLD_FILE_NAME
        );
    }


    /**
     * Load users from users.csv.
     *
     * Map format:
     *
     * username -> passwordHash
     */
    private static synchronized Map<String, String> loadUsers() {

        File csvFile = getCsvFile();

        /*
         * If users.csv does not exist,
         * try to migrate users.dat.
         */
        if (!csvFile.exists()) {

            File oldFile = getOldDatFile();

            if (oldFile.exists()) {

                Map<String, String> oldUsers =
                        loadOldDatFile(oldFile);

                if (!oldUsers.isEmpty()) {

                    /*
                     * Convert old plaintext passwords
                     * into secure password hashes.
                     */
                    Map<String, String> migratedUsers =
                            new HashMap<>();

                    for (Map.Entry<String, String> entry
                            : oldUsers.entrySet()) {

                        String username =
                                entry.getKey();

                        String password =
                                entry.getValue();

                        String hash =
                                hashPassword(password);

                        migratedUsers.put(
                                username,
                                hash
                        );
                    }

                    saveUsers(migratedUsers);

                    return migratedUsers;
                }
            }

            return new HashMap<>();
        }


        Map<String, String> users =
                new HashMap<>();


        try (BufferedReader reader =
                     new BufferedReader(
                             new FileReader(
                                     csvFile,
                                     StandardCharsets.UTF_8))) {

            /*
             * Skip header.
             */
            String line = reader.readLine();

            while ((line = reader.readLine()) != null) {

                if (line.trim().isEmpty()) {
                    continue;
                }

                List<String> values =
                        parseCSVLine(line);

                if (values.size() < 2) {
                    continue;
                }

                String username =
                        values.get(0);

                String passwordHash =
                        values.get(1);

                if (!username.trim().isEmpty()
                        && !passwordHash.trim().isEmpty()) {

                    users.put(
                            username,
                            passwordHash
                    );
                }
            }

        } catch (IOException e) {

            e.printStackTrace();
        }

        return users;
    }


    /**
     * Save users to users.csv.
     */
    private static synchronized void saveUsers(
            Map<String, String> users) {

        File file = getCsvFile();

        File parent =
                file.getParentFile();

        if (!parent.exists()) {
            parent.mkdirs();
        }


        try (BufferedWriter writer =
                     new BufferedWriter(
                             new FileWriter(
                                     file,
                                     StandardCharsets.UTF_8))) {

            /*
             * CSV header.
             */
            writer.write(
                    "Username,PasswordHash,Role"
            );

            writer.newLine();


            for (Map.Entry<String, String> entry
                    : users.entrySet()) {

                String username =
                        entry.getKey();

                String passwordHash =
                        entry.getValue();

                String role =
                        "admin".equalsIgnoreCase(username)
                                ? "ADMIN"
                                : "USER";

                writer.write(
                        csvValue(username)
                                + ","
                                + csvValue(passwordHash)
                                + ","
                                + role
                );

                writer.newLine();
            }

        } catch (IOException e) {

            throw new RuntimeException(
                    "Unable to save users.csv.",
                    e
            );
        }
    }


    /**
     * Check whether username already exists.
     */
    public static boolean userExists(
            String username) {

        if (username == null) {
            return false;
        }

        Map<String, String> users =
                loadUsers();

        return users.containsKey(
                username.trim()
        );
    }


    /**
     * Register a new user.
     */
    public static synchronized boolean registerUser(
            String username,
            String password) {

        if (username == null
                || password == null) {

            return false;
        }

        username = username.trim();

        Map<String, String> users =
                loadUsers();

        if (users.containsKey(username)) {
            return false;
        }


        /*
         * Hash the password before storing it.
         */
        String passwordHash =
                hashPassword(password);


        users.put(
                username,
                passwordHash
        );


        saveUsers(users);

        return true;
    }


    /**
     * Validate login credentials.
     */
    public static boolean validateUser(
            String username,
            String password) {

        if (username == null
                || password == null) {

            return false;
        }

        username = username.trim();

        Map<String, String> users =
                loadUsers();

        String storedHash =
                users.get(username);

        if (storedHash == null) {
            return false;
        }


        return verifyPassword(
                password,
                storedHash
        );
    }


    /**
     * Create a PBKDF2 password hash.
     *
     * Stored format:
     *
     * iterations:salt:hash
     */
    private static String hashPassword(
            String password) {

        try {

            byte[] salt =
                    new byte[SALT_LENGTH];

            RANDOM.nextBytes(salt);


            PBEKeySpec spec =
                    new PBEKeySpec(
                            password.toCharArray(),
                            salt,
                            ITERATIONS,
                            HASH_LENGTH
                    );


            SecretKeyFactory factory =
                    SecretKeyFactory.getInstance(
                            "PBKDF2WithHmacSHA256"
                    );


            byte[] hash =
                    factory.generateSecret(
                            spec
                    ).getEncoded();


            spec.clearPassword();


            return ITERATIONS
                    + ":"
                    + Base64.getEncoder()
                            .encodeToString(salt)
                    + ":"
                    + Base64.getEncoder()
                            .encodeToString(hash);


        } catch (Exception e) {

            throw new RuntimeException(
                    "Unable to hash password.",
                    e
            );
        }
    }


    /**
     * Verify a plain password against
     * the stored PBKDF2 hash.
     */
    private static boolean verifyPassword(
            String password,
            String storedHash) {

        try {

            String[] parts =
                    storedHash.split(":");

            if (parts.length != 3) {
                return false;
            }


            int iterations =
                    Integer.parseInt(parts[0]);


            byte[] salt =
                    Base64.getDecoder()
                            .decode(parts[1]);


            byte[] expectedHash =
                    Base64.getDecoder()
                            .decode(parts[2]);


            PBEKeySpec spec =
                    new PBEKeySpec(
                            password.toCharArray(),
                            salt,
                            iterations,
                            expectedHash.length * 8
                    );


            SecretKeyFactory factory =
                    SecretKeyFactory.getInstance(
                            "PBKDF2WithHmacSHA256"
                    );


            byte[] actualHash =
                    factory.generateSecret(
                            spec
                    ).getEncoded();


            spec.clearPassword();


            return MessageDigest.isEqual(
                    expectedHash,
                    actualHash
            );


        } catch (Exception e) {

            return false;
        }
    }


    /**
     * Load old users.dat.
     */
    @SuppressWarnings("unchecked")
    private static Map<String, String> loadOldDatFile(
            File file) {

        try (ObjectInputStream input =
                     new ObjectInputStream(
                             new FileInputStream(file))) {

            Object object =
                    input.readObject();

            if (object instanceof Map<?, ?>) {

                return (Map<String, String>) object;
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return new HashMap<>();
    }


    /**
     * Convert a value to CSV format.
     */
    private static String csvValue(
            String value) {

        if (value == null) {
            return "";
        }

        String escaped =
                value.replace(
                        "\"",
                        "\"\""
                );

        if (escaped.contains(",")
                || escaped.contains("\"")
                || escaped.contains("\n")
                || escaped.contains("\r")) {

            return "\"" + escaped + "\"";
        }

        return escaped;
    }


    /**
     * Parse a CSV line.
     */
    private static List<String> parseCSVLine(
            String line) {

        List<String> values =
                new ArrayList<>();

        StringBuilder current =
                new StringBuilder();

        boolean insideQuotes = false;


        for (int i = 0;
             i < line.length();
             i++) {

            char ch = line.charAt(i);


            if (ch == '"') {

                if (insideQuotes
                        && i + 1 < line.length()
                        && line.charAt(i + 1) == '"') {

                    current.append('"');

                    i++;

                } else {

                    insideQuotes =
                            !insideQuotes;
                }

            } else if (ch == ','
                    && !insideQuotes) {

                values.add(
                        current.toString()
                );

                current.setLength(0);

            } else {

                current.append(ch);
            }
        }


        values.add(
                current.toString()
        );

        return values;
    }
}