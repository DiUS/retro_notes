package code.model

import net.liftweb.mapper._
import net.liftweb.json.{JsonAST, JValue, Extraction}
import net.liftweb.util.Helpers
import net.liftweb.common.{Loggable, Empty, Box}
import code.lib.model.JxMetaMapperHelp

object Project extends Project with LongKeyedMetaMapper[Project] with Loggable with JxMetaMapperHelp[Project] {

  override def dbTableName = "project"



}

class Project extends LongKeyedMapper[Project] with IdPK with OneToMany[Long, Project] {
  private implicit val formats = net.liftweb.json.DefaultFormats

  override def getSingleton = Project

  object title extends MappedString(this, 256)

  object retros extends MappedOneToMany(Retro, Retro.project, OrderBy(Retro.id, Ascending))

}
