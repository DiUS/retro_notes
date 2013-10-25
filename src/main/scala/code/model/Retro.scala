package code.model

import net.liftweb.mapper._
import net.liftweb.json._
import net.liftweb.common.Box
import net.liftweb.util.Helpers

object Retro extends Retro with LongKeyedMetaMapper[Retro] {

  private implicit val formats = net.liftweb.json.DefaultFormats
  override def dbTableName = "retro"

  def apply(in: JValue): Box[Retro] = Helpers.tryo{in.extract[Retro]}
  def unapply(id: String): Option[Retro] = Retro.find(id)
  override def unapply(key : scala.Any) : Option[Retro] = {
    key match {
      case pk: String => Retro.unapply(pk)
      case _ => None
    }
  }

  implicit def toJson(item: Retro): JValue = {
    val refs = RetroReflection.findAll(By(RetroReflection.retro, item.id.get)).map(_.toReflectionType)
    val acts = Action.findAll(By(Action.retro, item.id.get)).map(_.toActionType)
    Extraction.decompose(RetroType(item.id.get, item.title.get, refs, acts))
  }
  implicit def toJson(items: List[Retro]): JValue = {
    val titles = items.map((p:Retro) => RetroBase(p.id.get, p.title.get))
    Extraction.decompose(titles)
  }

}

class Retro extends LongKeyedMapper[Retro] with IdPK with OneToMany[Long, Retro] {

  private implicit val formats = net.liftweb.json.DefaultFormats
  def getSingleton = Retro

  object project extends MappedLongForeignKey(this, Project)

  object title extends MappedString(this, 256)

  object retroReflections extends MappedOneToMany(RetroReflection, RetroReflection.retro, OrderBy(RetroReflection.id, Ascending))
  object actions extends MappedOneToMany(Action, Action.retro, OrderBy(Action.id, Ascending))


  // json ops
  def updateFromJson(in: JsonAST.JValue): Option[Retro] = {
    in.extractOpt[RetroTitle] match {
      case None => None
      case Some(pt: RetroTitle) => Some(title(pt.title))
    }
  }
}

case class RetroBase(id: Long, title: String)
case class RetroType(id: Long, title: String, reflections: List[ReflectionType], actions: List[ActionType])
case class RetroTitle(title: String)
