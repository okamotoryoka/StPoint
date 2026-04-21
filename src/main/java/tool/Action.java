package tool;

//HTTPリクエスト・レスポンスを扱うためのクラスをインポート
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/*
* Actionクラス
* すべてのアクションクラスの「親クラス（スーパークラス）」になる
*/
public abstract class Action {

 /*
  * executeメソッド（抽象メソッド）
  *
  * 【役割】
  * 各処理（検索・追加など）を実行するためのメソッド
  *
  * 【引数】
  * request  : リクエスト情報（パラメータ取得などに使用）
  * response : レスポンス情報（必要に応じて使用）
  *
  * 【戻り値】
  * 遷移先のJSPファイル名を返す(String型)
  *
  * 【ポイント】
  * abstractなので中身は書かない
  * 実際の処理は子クラス（SearchActionなど）で書く
  */
 public abstract String execute(
     HttpServletRequest request,
     HttpServletResponse response
 // executeメソッド：FrontControllerから呼ばれて
 // 具体的な処理をすることとなる
 ) throws Exception;
}
