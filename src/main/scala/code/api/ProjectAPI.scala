package code.api


import code.model._

import net.liftweb._
import common._
import http._
import rest._
import json._
import scala.xml._

object ProjectAPI extends RestHelper {

  /*
    serve the list of available projects
   */
  serve {
    case "project" :: Nil JsonGet _ => Project.findAll() : JValue
    case "project" :: Project(project) :: Nil JsonGet _ => project: JValue
  }

  /*
    create
   */
  serve {
    case "project" :: Nil JsonPut json -> _ => Project.createFromJson(json).map { p => p.save(); p: JValue }
  }



}
