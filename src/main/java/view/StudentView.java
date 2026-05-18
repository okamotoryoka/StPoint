package view;

import java.awt.BorderLayout;
import java.awt.GridLayout;
import java.util.List;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.JTextField;
import javax.swing.table.DefaultTableModel;

import Bean.Student;
import DAO.Student.StudentDAO;

public class StudentView extends JFrame {

    JTable table;
    DefaultTableModel model;

    JTextField txtNo = new JTextField();
    JTextField txtName = new JTextField();
    JTextField txtYear = new JTextField();
    JTextField txtClass = new JTextField();

    JTextField txtSearchName = new JTextField();
    JTextField txtSearchClass = new JTextField();

    JButton updateBtn = new JButton("更新");
    JButton searchBtn = new JButton("検索");
    JButton resetBtn = new JButton("全件表示");

    StudentDAO dao = new StudentDAO();

    public StudentView() {

        setTitle("生徒管理システム");
        setSize(700, 500);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
        setLayout(new BorderLayout());

        // テーブル
        model = new DefaultTableModel();
        model.addColumn("学籍番号");
        model.addColumn("名前");
        model.addColumn("入学年");
        model.addColumn("クラス");

        table = new JTable(model);
        add(new JScrollPane(table), BorderLayout.CENTER);

        // フォーム
        JPanel form = new JPanel(new GridLayout(6,2));

        form.add(new JLabel("No"));
        form.add(txtNo);

        form.add(new JLabel("名前"));
        form.add(txtName);

        form.add(new JLabel("入学年"));
        form.add(txtYear);

        form.add(new JLabel("クラス"));
        form.add(txtClass);

        form.add(updateBtn);

        // 検索
        form.add(new JLabel("検索(名前)"));
        form.add(txtSearchName);

        form.add(new JLabel("検索(クラス)"));
        form.add(txtSearchClass);

        form.add(searchBtn);
        form.add(resetBtn);

        add(form, BorderLayout.SOUTH);

        // 初期表示
        loadTable();

        // 行選択 → フォーム反映
        table.getSelectionModel().addListSelectionListener(e -> {

            int row = table.getSelectedRow();
            if (row == -1) return;

            txtNo.setText(model.getValueAt(row, 0).toString());
            txtName.setText(model.getValueAt(row, 1).toString());
            txtYear.setText(model.getValueAt(row, 2).toString());
            txtClass.setText(model.getValueAt(row, 3).toString());
        });

        // 更新
        updateBtn.addActionListener(e -> updateStudent());

        // 検索
        searchBtn.addActionListener(e -> search());

        // 全件表示
        resetBtn.addActionListener(e -> loadTable());

        setVisible(true);
    }

    // 全件表示
    public void loadTable() {

        try {
            List<Student> list = dao.findAll();

            model.setRowCount(0);

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

    // 更新
    public void updateStudent() {

        try {
            Student s = new Student();

            s.setNo(txtNo.getText());
            s.setName(txtName.getText());
            s.setEntYear(Integer.parseInt(txtYear.getText()));
            s.setClassNum(txtClass.getText());
            s.setIsAttend(true);

            dao.update(s);

            loadTable();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 検索
    public void search() {

        try {
            String name = txtSearchName.getText();
            String classNum = txtSearchClass.getText();

            List<Student> list =
                    dao.search(name, classNum, "");

            model.setRowCount(0);

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
        new StudentView();
    }
}