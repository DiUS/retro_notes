package code.model

import net.liftweb.mapper._
import net.liftweb.json.{JsonAST, JValue, Extraction}
import net.liftweb.util.Helpers
import net.liftweb.common.{Empty, Box}

object Project extends Project with LongKeyedMetaMapper[Project] {

  override def dbTableName = "project"
  private implicit val formats = net.liftweb.json.DefaultFormats

  def createFromJson(in: JsonAST.JValue): Option[Project] = {
    (in \ "title").extractOpt[String] match {
      case None => None
      case title => {
        val project = Project.create
        project.title(title)
        Some(project)
      }
    }
  }

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

class Project extends LongKeyedMapper[Project] with IdPK with OneToMany[Long, Project] {

  def getSingleton = Project

  object title extends MappedString(this, 256)

  object retros extends MappedOneToMany(Retro, Retro.project, OrderBy(Retro.id, Ascending))

}

