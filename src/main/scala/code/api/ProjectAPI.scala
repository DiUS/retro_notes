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
  serve {
    case "project" :: Nil JsonGet _ => Project.findAll() : JValue
    case "project" :: Project(project) :: Nil JsonGet _ => project: JValue
    case "project" :: Project(project) :: Nil JsonDelete _ => {
      Project.delete_!(project)
      JNull
    }
    case "project" :: Project(project) :: Nil JsonPut json -> _ => project.updateFromJson(json).map { p => p.saveMe(): JValue }
    case "project" :: Nil JsonPost json -> _ => Project.createFromJson(json).map { p => p.saveMe(): JValue }
  }

}
