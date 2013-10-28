package code.api


import code.model._

import net.liftweb._
import common._
import http._
import rest._
import json._
import scala.xml._

object ProjectAPI extends RestHelper with Loggable {

  /*
    serve projects
   */
  serve("api" / "projects" prefix {
    case Nil JsonGet _ => Project.findAll() : JValue
    case Project(project) :: Nil JsonGet _ => project: JValue
    case Project(project) :: Nil JsonDelete _ => { Project.delete_!(project); JNull }
    case Project(project) :: Nil JsonPut json -> _ => project.updateFromJson(json).map { p => p.saveMe(): JValue }
    case Nil JsonPost json -> _ => Project.createFromJson(json).map { p => p.saveMe(): JValue }
  })

  /*
    serve retros
   */
  serve("api" / "retros" prefix {
    case Retro(retro) :: Nil JsonGet _ => retro: JValue
    case Retro(retro) :: Nil JsonDelete _ => { Retro.delete_!(retro); JNull }
    case Retro(retro) :: Nil JsonPut json -> _ => retro.updateFromJson(json).map { r => r.saveMe(): JValue }
    case Nil JsonPost json -> _ => Project.createRetroFromJson(json).map { r => r.saveMe(): JValue }
  })

}
