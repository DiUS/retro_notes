package code.model

import net.liftweb.mapper._
import net.liftweb.json.{JValue, Extraction}
import net.liftweb.util.Helpers
import net.liftweb.common.Box


object Project extends Project with LongKeyedMetaMapper[Project] {
  override def dbTableName = "project"

  private implicit val formats = net.liftweb.json.DefaultFormats

  def apply(in: JValue): Box[Project] = Helpers.tryo{in.extract[Project]}
  def unapply(id: String): Option[Project] = Project.find(id)
  override def unapply(key : scala.Any) : Option[Project] = {
    key match {
      case pk: String => Project.unapply(pk)
      case _ => None
    }
  }

  implicit def toJson(item: Project): JValue = Extraction.decompose(item)
  implicit def toJson(items: List[Project]): JValue = Extraction.decompose(items)

}

class Project extends LongKeyedMapper[Project] with IdPK {

  def getSingleton = Project

  object title extends MappedString(this, 256)

}
