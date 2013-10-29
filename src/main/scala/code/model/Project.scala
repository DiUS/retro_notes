package code.model

import net.liftweb.mapper._
import net.liftweb.json.{JsonAST, JValue, Extraction}
import net.liftweb.util.Helpers
import net.liftweb.common.{Loggable, Empty, Box}

object Project extends Project with LongKeyedMetaMapper[Project] with Loggable with JxMetaHelp[Project] {

  override def dbTableName = "project"



}

class Project extends LongKeyedMapper[Project] with IdPK with OneToMany[Long, Project] with JxHelp[Project] {
  private implicit val formats = net.liftweb.json.DefaultFormats

  override def getSingleton = Project

  object title extends MappedString(this, 256)

  object retros extends MappedOneToMany(Retro, Retro.project, OrderBy(Retro.id, Ascending))

}
