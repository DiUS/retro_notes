package code.api

import code.model.{Project}
import Project._
import net.liftweb.http.{PutRequest, DeleteRequest}

object ProjectAPI extends RestJxHelp[Project] {

  /* CRUD for project(s) */
  serveJx[Any] {

    List("projects") prefixJx {

      case Nil Get req => findAll()

      case Nil Post req => create(req) map saved

      case Project(item) :: Nil RUDAction req => req.requestType match {
        case DeleteRequest => delete(item) ?~ "Failed to delete project"
        case PutRequest    => update(item, req) map saved
        case _ => item
      }
    }
  }

}
