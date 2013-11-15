package code.api

import code.model.{RetroReflection, RetroResponse}
import RetroResponse._
import net.liftweb.http.{PostRequest, PutRequest, GetRequest}
import net.liftweb.mapper.By
import code.lib.api.{CRUDActionMatching, JxConversions}

object RetroResponseAPI extends JxConversions[RetroResponse] with CRUDActionMatching {

  type ONE = RetroResponse
  type MANY = List[ONE]

  serveJx[ONE] {
    case "reflections" :: RetroReflection(reflection) :: "responses" :: Nil Post req => {
      create[RetroReflection](reflection, req) map saved
    }
    case "responses" :: RetroResponse(response) :: Nil RUAction req => req.requestType match {
      case PutRequest => update(response, req) map saved
      case _          => response
    }
  }

  serveJx[Boolean] {
    case "responses" :: RetroResponse(response) :: Nil Delete req => {
      delete(response) ?~ s"Failed to save response ${response.id}"
    }
  }

  serveJx[MANY] {
    case "reflections" :: RetroReflection(reflection) :: "responses" :: Nil Get req => {
      findAll(By(retroReflection, reflection))
    }
  }

}
