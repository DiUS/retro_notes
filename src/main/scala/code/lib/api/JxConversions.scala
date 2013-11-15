package code.lib.api

import net.liftweb.mapper.LongKeyedMapper
import net.liftweb.http.rest.{XmlSelect, JsonSelect, RestHelper}
import net.liftweb.json._
import net.liftweb.http._
import scala.Some
import scala.xml.Node
import code.lib.model.JxMapperHelp

trait JxConversions[A <: LongKeyedMapper[A]] extends RestHelper {

  /**
   * Convenience for mapping a Box[A] or Option[A] to a saved value
   * Example usage 1: boxedValue map saved
   * Example usage 2: boxedValue.map(saved(_))
   *
   * @param a the mapper entity instance
   * @return the saved instance
   */
  protected def saved(a: A): A = a.saveMe()

  private def toJSON(a: A): JValue = JxMapperHelp.toJSON(a)
  private def toXML(a: A): Node = JxMapperHelp.toXML(a)
  private def toJSON(l: List[A]): JValue = JArray(for (a <- l) yield toJSON(a))
  private def toXML(l: List[A]): Node = <list>{l.mapConserve(a => toXML(a))}</list>

  /**
   * Partial convertion function to convert the response to either Json or Xml
   * depending on the accepts headers.
   *
   * @return
   */
  // TODO: fix warnings for type erasure
//  implicit def anyResponseByAccepts: JxCvtPF[Any] = {
//    case (JsonSelect, l: List[A], _) => toJSON(l)
//    case (XmlSelect, l: List[A], _)  => toXML(l)
//
//    case (JsonSelect, a: A, _) => toJSON(a)
//    case (XmlSelect, a: A, _)  => toXML(a)
//
//    case (JsonSelect, a: Boolean, _) => JBool(a)
//    case (XmlSelect, a: Boolean, _) => <result>{a}</result>
//  }

  implicit def listResponseByAccepts: JxCvtPF[List[A]] = {
    case (JsonSelect, l, _) => toJSON(l)
    case (XmlSelect, l, _)  => toXML(l)
  }

  implicit def itemResponseByAccepts: JxCvtPF[A] = {
    case (JsonSelect, a, _) => toJSON(a)
    case (XmlSelect, a, _)  => toXML(a)
  }

  implicit def boolResponseByAccepts: JxCvtPF[Boolean] = {
    case (JsonSelect, b, _) => JBool(b)
    case (XmlSelect, b, _) => <result>{b}</result>
  }

  /**
   * Obtains posted json or xml to json, so as to treat
   * rest posts uniformly
   *
   * @param req - the request
   * @return a JValue or JNull
   */
  implicit def postedJSON(req: Req): JValue = {
    if (req.xml_?) Xml.toJson(req.xml.get)
    else if (req.json_?) req.json.get
    else JNull
  }

}
