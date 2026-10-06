package com.sms.dao;

import java.util.ArrayList;
import java.util.List;

import com.sms.model.Student;
import com.sms.util.FileStorage;

public class StudentDAO {

    public List<Student> getAllStudents() {
        return FileStorage.loadStudents();
    }

    public Student getStudentById(String studentId) {

        if (studentId == null) {
            return null;
        }

        for (Student student : getAllStudents()) {

            if (studentId.equalsIgnoreCase(
                    student.getStudentId())) {

                return student;
            }
        }

        return null;
    }

    public boolean addStudent(Student student) {

        List<Student> students =
                new ArrayList<>(getAllStudents());

        if (getStudentById(student.getStudentId()) != null) {
            return false;
        }

        students.add(student);
        FileStorage.saveStudents(students);

        return true;
    }

    public boolean updateStudent(Student updatedStudent) {

        List<Student> students =
                new ArrayList<>(getAllStudents());

        for (int i = 0; i < students.size(); i++) {

            if (students.get(i).getStudentId()
                    .equalsIgnoreCase(
                            updatedStudent.getStudentId())) {

                students.set(i, updatedStudent);
                FileStorage.saveStudents(students);

                return true;
            }
        }

        return false;
    }

    public boolean deleteStudent(String studentId) {

        List<Student> students =
                new ArrayList<>(getAllStudents());

        boolean removed = students.removeIf(
                student -> student.getStudentId()
                        .equalsIgnoreCase(studentId)
        );

        if (removed) {
            FileStorage.saveStudents(students);
        }

        return removed;
    }

    public List<Student> searchStudents(String keyword) {

        List<Student> students = getAllStudents();

        if (keyword == null ||
                keyword.trim().isEmpty()) {

            return students;
        }

        keyword = keyword.toLowerCase().trim();

        List<Student> result = new ArrayList<>();

        for (Student student : students) {

            if (contains(student.getStudentId(), keyword)
                    || contains(student.getName(), keyword)
                    || contains(student.getEmail(), keyword)
                    || contains(student.getCourse(), keyword)
                    || contains(student.getDepartment(), keyword)) {

                result.add(student);
            }
        }

        return result;
    }

    private boolean contains(String value, String keyword) {

        return value != null &&
                value.toLowerCase().contains(keyword);
    }
}