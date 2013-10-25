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
  serve ( "retro" / "project" prefix {
    case Nil JsonGet _ => Project.findAll() : JValue
    case Project(project) :: Nil JsonGet _ => project: JValue
  })


}
