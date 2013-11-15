package code.api

import code.model.Retro._
import code.model.{Project, Retro}
import net.liftweb.http.{GetRequest, PutRequest}
import net.liftweb.mapper.By
import code.lib.api.{CRUDActionMatching, JxConversions}

object RetroAPI extends JxConversions[Retro] with CRUDActionMatching {

  type ONE = Retro
  type MANY = List[ONE]

  serveJx[ONE] {
    case "retros" :: Retro(item) :: Nil RUAction req => req.requestType match {
      case PutRequest => update(item, req) map saved
      case _          => item
    }
    case "projects" :: Project(project) :: "retros" :: Nil Post req => {
      create[Project](project, req) map saved
    }
  }

  serveJx[Boolean] {
    case "retros" :: Retro(retro) :: Nil Delete req => {
      delete(retro) ?~ "Failed to delete project"
    }
  }

  serveJx[MANY] {
    case "projects" :: Project(project) :: "retros" :: Nil Get req => {
      findAll(By(Retro.project, project))
    }
  }
}
