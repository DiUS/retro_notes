package code.model

import net.liftweb.mapper._
import net.liftweb.json.{JsonAST, JValue, Extraction}
import net.liftweb.util.Helpers
import net.liftweb.common.{Loggable, Empty, Box}

object Project extends Project with LongKeyedMetaMapper[Project] with Loggable {

  override def dbTableName = "project"
  private implicit val formats = net.liftweb.json.DefaultFormats

  def createFromJson(in: JsonAST.JValue): Option[Project] = {
    in.extractOpt[ProjectTitle] match {
      case None => None
      case Some(projectTitle) => {
        Some(Project.create.title(projectTitle.title))
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

  implicit def toJson(item: Project): JValue = Extraction.decompose(ProjectType(item.id.get, item.title.get))
  implicit def toJson(items: List[Project]): JValue = {
    val titles = items.map((p:Project) => ProjectType(p.id.get, p.title.get))
    Extraction.decompose(titles)
  }

}

class Project extends LongKeyedMapper[Project] with IdPK with OneToMany[Long, Project] {
  private implicit val formats = net.liftweb.json.DefaultFormats

  def getSingleton = Project

  object title extends MappedString(this, 256)

  object retros extends MappedOneToMany(Retro, Retro.project, OrderBy(Retro.id, Ascending))

  def updateFromJson(in: JsonAST.JValue): Option[Project] = {
    in.extractOpt[ProjectTitle] match {
      case None => None
      case Some(pt: ProjectTitle) => Some(title(pt.title))
    }
  }

}

case class ProjectType(id: Long, title: String)
case class ProjectTitle(title: String)