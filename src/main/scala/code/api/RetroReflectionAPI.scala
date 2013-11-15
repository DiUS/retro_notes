package code.api

import code.model.{Retro, RetroReflection}
import net.liftweb.http.{PutRequest, GetRequest, PostRequest}
import RetroReflection._
import net.liftweb.mapper.By
import code.lib.api.{CRUDActionMatching, JxConversions}


object RetroReflectionAPI extends JxConversions[RetroReflection] with CRUDActionMatching {

  type ONE = RetroReflection
  type MANY = List[ONE]

  serveJx[ONE] {
    case "reflections" :: RetroReflection(reflection) :: Nil RUAction req => req.requestType match {
      case PutRequest => update(reflection, req) map saved
      case _          => reflection
    }
    case "retros" :: Retro(retro) :: "reflections" :: Nil Post req => {
      create[Retro](retro, req) map saved
    }
  }

  serveJx[Boolean] {
    case "reflections" :: RetroReflection(reflection) :: Nil Delete req => {
      delete(reflection) ?~ s"Failed to delete reflection [${reflection.id}]"
    }
  }

  serveJx[MANY] {
    case "retros" :: Retro(retro) :: "reflections" :: Nil Get req => {
      findAll(By(RetroReflection.retro, retro))
    }
  }

}
