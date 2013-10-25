package code.model

import net.liftweb.mapper._


object Project extends Project with LongKeyedMetaMapper[Project] {
  override def dbTableName = "project"


}

class Project extends LongKeyedMapper[Project] with IdPK {

  def getSingleton = Project

  object dateCreated extends MappedDateTime(this)
  object name extends MappedString(this, 256)

}
