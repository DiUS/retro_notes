package code.api

import net.liftweb.mapper.{LongKeyedMapper}
import net.liftweb.http.rest.{XmlSelect, JsonSelect, RestHelper}
import net.liftweb.json._
import scala.xml.Node
import net.liftweb.http._
import scala.Some
import code.model.JxHelp
import JxHelp._

trait RestJxHelp[A <: LongKeyedMapper[A] with JxHelp[A]] extends RestHelper {

  protected object RUDAction {
    val accepts = GetRequest :: PutRequest :: DeleteRequest :: Nil

    def unapply(r: Req): Option[(List[String], Req)] =
      if (accepts.contains(r.requestType)) Some(r.path.partPath -> r) else None
  }

  protected object CRAction {
    val accepts = PostRequest :: GetRequest :: Nil

    def unapply(r: Req): Option[(List[String], Req)] =
      if (accepts.contains(r.requestType)) Some(r.path.partPath -> r) else None
  }

  protected def saved(a: A): A = a.saveMe()

  implicit def itemToResponseByAccepts: JxCvtPF[Any] = {
    case (JsonSelect, l : List[A], _) => JArray(for (item <- l) yield item: JValue)

    case (XmlSelect, l : List[A], _) => <list>{l.mapConserve(item => item: Node)}</list>

    case (JsonSelect, c: A, _) => c: JValue
    case (XmlSelect, c: A, _) => c: Node
  }

  implicit def toJSON(req: Req): JValue = {
    if (req.xml_?) Xml.toJson(req.xml.get)
    else req.json.get
  }

}
