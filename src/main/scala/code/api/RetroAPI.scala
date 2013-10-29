package code.api

import code.model.Retro._
import code.model.{Project, Retro}
import net.liftweb.http.{PostRequest, GetRequest, PutRequest, DeleteRequest}
import net.liftweb.mapper.By

object RetroAPI extends RestJxHelp[Retro] {

  /* CRUD for retro(s) */
  serveJx[Any] {
    case "retros" :: Retro(item) :: Nil RUDAction req => req.requestType match {
      case DeleteRequest => delete(item) ?~ "Failed to delete project"
      case PutRequest    => update(item, req) map saved
      case _ => item
    }

    case "projects" :: Project(project) :: "retros" :: Nil CRAction req => req.requestType match {
      case GetRequest => findAll(By(Retro.project, project))
      case PostRequest => create[Project](project, req) map saved
    }
  }
}
