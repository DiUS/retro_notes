package code.lib.api

import net.liftweb.http._
import scala.Some

trait CRUDActionMatching {

  protected abstract class ReqAction {
    val accepts: List[RequestType]

    def unapply(r: Req): Option[(List[String], Req)] =
      if (accepts.contains(r.requestType)) Some(r.path.partPath -> r) else None
  }

  protected object CRUDAction extends ReqAction {
    val accepts = PostRequest :: GetRequest :: PutRequest :: DeleteRequest :: Nil
  }

  /**
   * Read, Update, or Delete action matching
   */
  protected object RUAction extends ReqAction {
    val accepts = GetRequest :: PutRequest :: Nil
  }

  /**
   * Read, Update, or Delete action matching
   */
  protected object RUDAction extends ReqAction {
    val accepts = GetRequest :: PutRequest :: DeleteRequest :: Nil
  }

  /**
   * Create or Read action matching
   */
  protected object CRAction extends ReqAction {
    val accepts = PostRequest :: GetRequest :: Nil
  }

}
