package code.api

import code.model.Project
import code.model.Project._
import net.liftweb.http.{GetRequest, PutRequest}
import code.lib.api.{CRUDActionMatching, JxConversions}

object ProjectAPI extends JxConversions[Project] with CRUDActionMatching {

  type ONE = Project
  type MANY = List[ONE]

  serveJx[ONE] {
    List("projects") prefixJx {
      case Project(project) :: Nil RUAction req => req.requestType match {
        case PutRequest => update(project, req) map saved
        case _          => project
      }
      case Nil Post req => create(req) map saved
    }
  }

  serveJx[Boolean] {
    case "projects" :: Project(project) :: Nil Delete req => {
      delete(project) ?~ "Failed to delete project"
    }
  }

  serveJx[MANY] {
    case "projects" :: Nil Get req => findAll()
  }

}
