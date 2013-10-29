package code.model

import net.liftweb.json._
import scala.xml.{Text, Elem, Node}
import net.liftweb.mapper._
import net.liftweb.common.{Box}
import net.liftweb.util.{BaseField, Helpers}
import net.liftweb.json.JValue

object JxHelp {
  implicit val formats = net.liftweb.json.DefaultFormats

  type Exported = Map[String, String]

  private def toJSON(a: Exported): JValue = Extraction.decompose(a)

  private def toXML(a: Exported, name: String): Node = {
    val values = a.map { case (k,v) => Elem(null, k, scala.xml.Null, scala.xml.TopScope, true, Text(v)) }.toSeq
    Elem(null, name, scala.xml.Null, scala.xml.TopScope, true, values: _*)
  }

  implicit def toJSON[A <: LongKeyedMapper[A] with JxHelp[A]](a: A): JValue =
    toJSON(a.toExported)

  implicit def toXML[A <: LongKeyedMapper[A] with JxHelp[A]](a: A): Node =
    toXML(a.toExported, a.getClass.getSimpleName)

}

trait JxMetaHelp[A <: LongKeyedMapper[A]] { self: LongKeyedMetaMapper[A] =>

  import JxHelp._

  lazy val nodeName = getClass.getSimpleName

  /* CREATE */
  def create[O <: LongKeyedMapper[O]](owner: O, in: JValue): Box[A] = Helpers.tryo {
    val a: A = self.create
    updateToOne(a, owner)
    update(a, in.extract[Exported])
    a
  }
  def create(in: JValue): Box[A] = apply(in)

  def apply(in: JValue): Box[A] = Helpers.tryo {
    val a: A = self.create
    val kv = in.extract[Exported]
    update(a, kv)
  }

  /* UPDATE */
  def update(a: A, in: JValue): Box[A] = Helpers.tryo {
    val kv = in.extract[Exported]
    update(a, kv)
  }

  private def isForeignKey(f: BaseField): Boolean = f.isInstanceOf[MappedLongForeignKey[A, _]]

  def updateToOne[O <: LongKeyedMapper[O]](a: A, relation: O): Boolean = {
    val ownerName = relation.getClass.getSimpleName.toLowerCase
    a.allFields.find(f => isForeignKey(f) && f.name == ownerName).map(_.asInstanceOf[MappedLongForeignKey[A, O]]) match {
      case Some(f) => f(relation); true
      case _ => false
    }
  }

  private[JxMetaHelp] val illegalApplyKeys = Set("id", "_id")
  private def update(a: A, kv: Exported): A = {
    if (kv.keySet.find(k => illegalApplyKeys.contains(k) || fieldByName(k).isEmpty).nonEmpty)
      throw new IllegalArgumentException("Illegal API usage")

    a.allFields.filter(!_.isInstanceOf[BaseForeignKey]).map(_.asInstanceOf[MappedField[_, A]]).foreach { f =>
      kv.get(f.name) match {
        case Some(v) => f.setFromAny(v)
        case _ =>
      }
    }
    a
  }

  /* DELETE */
  def delete(a: A): Box[Boolean] = Helpers.tryo {
    delete_!(a)
  }

  def delete(pk: Long): Box[Boolean] = Helpers.tryo {
    val a: Option[A] = unapply(pk)
    delete_!(a.get)
  }
}

trait JxHelp[A <: LongKeyedMapper[A]] { self : LongKeyedMapper[A] =>

  import JxHelp._

  def toExported: Exported =
    allFields.map(f => (f.name, f.asHtml.text)).toMap

}
