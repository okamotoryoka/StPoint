package DAO;

import java.sql.Connection;

import javax.naming.InitialContext;
import javax.sql.DataSource;

// DAOの共通クラス
// このクラスは「データベース接続」を担当する
public class DAO {

    // データソース（DB接続情報）
    // staticにすることで、全DAOクラスで共有できる
    static DataSource ds;

    // データベース接続
    public Connection getConnection() throws Exception {

        // まだデータソースを取得していない場合
        if (ds == null) {

        	// ① Tomcatの設定(context.xml)を取得
            InitialContext ic = new InitialContext();

            // ② データ取得
            // jdbc/book という名前のDB設定を取得
            ds = (DataSource) ic.lookup("java:/comp/env/jdbc/stpoint");
        }

        // データソースからDB接続を取得して返す
        return ds.getConnection();
    }
}