package com.sms.service;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.sms.dao.StudentDAO;
import com.sms.model.Student;

public class StudentService {

    private final StudentDAO studentDAO;

    public StudentService() {
        studentDAO = new StudentDAO();
    }

    public List<Student> getAllStudents() {
        return studentDAO.getAllStudents();
    }

    public Student getStudent(String studentId) {
        return studentDAO.getStudentById(studentId);
    }

    public boolean addStudent(Student student) {

        if (student == null ||
                student.getStudentId() == null ||
                student.getStudentId().trim().isEmpty()) {

            return false;
        }

        return studentDAO.addStudent(student);
    }

    public boolean updateStudent(Student student) {

        if (student == null) {
            return false;
        }

        return studentDAO.updateStudent(student);
    }

    public boolean deleteStudent(String studentId) {

        if (studentId == null ||
                studentId.trim().isEmpty()) {

            return false;
        }

        return studentDAO.deleteStudent(studentId);
    }

    public List<Student> searchStudents(String keyword) {
        return studentDAO.searchStudents(keyword);
    }

    public int getTotalStudents() {
        return getAllStudents().size();
    }

    public int getMaleStudents() {

        int count = 0;

        for (Student student : getAllStudents()) {

            if ("Male".equalsIgnoreCase(
                    student.getGender())) {

                count++;
            }
        }

        return count;
    }

    public int getFemaleStudents() {

        int count = 0;

        for (Student student : getAllStudents()) {

            if ("Female".equalsIgnoreCase(
                    student.getGender())) {

                count++;
            }
        }

        return count;
    }

    /*
     * Get department-wise student count.
     *
     * Example:
     *
     * CSE       -> 4
     * ECE       -> 2
     * EEE       -> 1
     * BTech     -> 1
     *
     */
    public Map<String, Integer> getDepartmentCounts() {

        Map<String, Integer> departmentCounts =
                new LinkedHashMap<>();

        for (Student student : getAllStudents()) {

            String department = student.getDepartment();

            if (department == null ||
                    department.trim().isEmpty()) {

                department = "Not Specified";

            } else {

                department = department.trim();
            }

            departmentCounts.put(
                    department,
                    departmentCounts.getOrDefault(
                            department,
                            0
                    ) + 1
            );
        }

        return departmentCounts;
    }
}