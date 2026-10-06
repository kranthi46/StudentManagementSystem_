package com.sms.util;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.EOFException;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.util.ArrayList;
import java.util.List;

import com.sms.model.Student;

public class FileStorage {

    private static final String DIRECTORY_NAME =
            "student-management-system";

    private static final String CSV_FILE_NAME =
            "students.csv";

    /*
     * Old Java serialized file.
     * This is used only for the first migration.
     */
    private static final String OLD_FILE_NAME =
            "students.dat";


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
     * Get CSV file.
     */
    private static File getDataFile() {

        return new File(
                getDataDirectory(),
                CSV_FILE_NAME
        );
    }


    /**
     * Get old DAT file.
     */
    private static File getOldDataFile() {

        return new File(
                getDataDirectory(),
                OLD_FILE_NAME
        );
    }


    /**
     * Load students from CSV.
     *
     * If students.csv does not exist but students.dat exists,
     * the old DAT file will automatically be converted to CSV.
     */
    public static synchronized List<Student> loadStudents() {

        File csvFile = getDataFile();

        /*
         * If CSV does not exist, try migrating
         * the existing students.dat file.
         */
        if (!csvFile.exists()) {

            File oldFile = getOldDataFile();

            if (oldFile.exists()) {

                List<Student> oldStudents =
                        loadOldDatFile(oldFile);

                if (!oldStudents.isEmpty()) {

                    saveStudents(oldStudents);

                    return oldStudents;
                }
            }

            return new ArrayList<>();
        }


        List<Student> students =
                new ArrayList<>();


        try (BufferedReader reader =
                     new BufferedReader(
                             new FileReader(
                                     csvFile))) {

            /*
             * Skip CSV header.
             */
            String line = reader.readLine();

            while ((line = reader.readLine()) != null) {

                if (line.trim().isEmpty()) {
                    continue;
                }

                List<String> values =
                        parseCSVLine(line);

                /*
                 * We need 10 columns.
                 */
                if (values.size() < 10) {
                    continue;
                }

                Student student =
                        new Student(
                                values.get(0),
                                values.get(1),
                                values.get(2),
                                values.get(3),
                                values.get(4),
                                values.get(5),
                                values.get(6),
                                values.get(7),
                                values.get(8),
                                values.get(9)
                        );

                students.add(student);
            }

        } catch (IOException e) {

            e.printStackTrace();
        }

        return students;
    }


    /**
     * Save all students to students.csv.
     */
    public static synchronized void saveStudents(
            List<Student> students) {

        File file = getDataFile();

        try (BufferedWriter writer =
                     new BufferedWriter(
                             new FileWriter(file))) {

            /*
             * CSV header
             */
            writer.write(
                    "Student ID,Name,Email,Phone,Gender,DOB,Course,Department,Year,Address"
            );

            writer.newLine();


            /*
             * Write every student.
             */
            for (Student student : students) {

                writer.write(
                        csvValue(student.getStudentId())
                                + ","
                                + csvValue(student.getName())
                                + ","
                                + csvValue(student.getEmail())
                                + ","
                                + csvValue(student.getPhone())
                                + ","
                                + csvValue(student.getGender())
                                + ","
                                + csvValue(student.getDob())
                                + ","
                                + csvValue(student.getCourse())
                                + ","
                                + csvValue(student.getDepartment())
                                + ","
                                + csvValue(student.getYear())
                                + ","
                                + csvValue(student.getAddress())
                );

                writer.newLine();
            }

        } catch (IOException e) {

            throw new RuntimeException(
                    "Unable to save students to CSV file.",
                    e
            );
        }
    }


    /**
     * Convert a value into a CSV-safe value.
     *
     * Example:
     *
     * Potnuru Sai Kranthi Kumar
     *
     * becomes:
     *
     * "Potnuru Sai Kranthi Kumar"
     */
    private static String csvValue(String value) {

        if (value == null) {
            return "";
        }

        String escaped =
                value.replace("\"", "\"\"");

        /*
         * Put quotes around values containing
         * comma, quote or newline.
         */
        if (escaped.contains(",")
                || escaped.contains("\"")
                || escaped.contains("\n")
                || escaped.contains("\r")) {

            return "\"" + escaped + "\"";
        }

        return escaped;
    }


    /**
     * Parse one CSV line.
     *
     * This supports values containing commas
     * inside quotation marks.
     */
    private static List<String> parseCSVLine(
            String line) {

        List<String> values =
                new ArrayList<>();

        StringBuilder current =
                new StringBuilder();

        boolean insideQuotes = false;


        for (int i = 0; i < line.length(); i++) {

            char ch = line.charAt(i);


            if (ch == '"') {

                /*
                 * Two quotes inside quoted value
                 * represent one quote.
                 */
                if (insideQuotes
                        && i + 1 < line.length()
                        && line.charAt(i + 1) == '"') {

                    current.append('"');

                    i++;

                } else {

                    insideQuotes = !insideQuotes;
                }

            } else if (ch == ','
                    && !insideQuotes) {

                values.add(current.toString());

                current.setLength(0);

            } else {

                current.append(ch);
            }
        }


        values.add(current.toString());

        return values;
    }


    /**
     * Load the old Java serialized students.dat file.
     *
     * This method is used only during migration
     * from DAT to CSV.
     */
    @SuppressWarnings("unchecked")
    private static List<Student> loadOldDatFile(
            File file) {

        List<Student> students =
                new ArrayList<>();

        try (ObjectInputStream input =
                     new ObjectInputStream(
                             new FileInputStream(file))) {

            Object object =
                    input.readObject();

            if (object instanceof List<?>) {

                students =
                        (List<Student>) object;
            }

        } catch (EOFException e) {

            return new ArrayList<>();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return students;
    }
}