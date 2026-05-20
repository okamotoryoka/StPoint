package view;
import java.awt.BorderLayout;
import java.util.List;

import javax.swing.JFrame;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;

import Bean.Student;
import DAO.Student.StudentDAO;

public class StudentTableView extends JFrame {

    JTable table;
    DefaultTableModel model;

    StudentDAO dao = new StudentDAO();

    public StudentTableView() {

        setTitle("生徒一覧");
        setSize(600, 300);
        setDefaultCloseOperation(EXIT_ON_CLOSE);

        // テーブル作成
        model = new DefaultTableModel();

        model.addColumn("学籍番号");
        model.addColumn("名前");
        model.addColumn("入学年");
        model.addColumn("クラス");

        table = new JTable(model);

        add(new JScrollPane(table), BorderLayout.CENTER);

        // データ読み込み
        loadTable();

        setVisible(true);
    }

    // ★ここが核心
    public void loadTable() {

        try {
            List<Student> list = dao.findAll();

            model.setRowCount(0); // 一度クリア

            for (Student s : list) {
                model.addRow(new Object[]{
                        s.getNo(),
                        s.getName(),
                        s.getEntYear(),
                        s.getClassNum()
                });
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        new StudentTableView();
    }
}