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
    serve the list of available projects
   */
  serve {
    case "project" :: Nil JsonGet _ => Project.findAll() : JValue
    case "project" :: Nil JsonPost json -> _ => {
      logger.warn("json: " + json)
      Project.createFromJson(json).map { p => p.save(); p: JValue }
    }
    case "project" :: Project(project) :: Nil JsonGet _ => project: JValue
  }



}
