package code.lib.api

import net.liftweb.http.Req
import code.model.Retro
import net.liftweb.common._
import BoxOrRaw._

trait RetroOwnerActioning extends OwnerActioning with CRUDActionMatching {

  protected def retroAction[T](test:(Req) => Boolean)(action: (Req, Retro) => BoxOrRaw[T]): PartialFunction[Req, BoxOrRaw[T]] = ownerAction[Retro, T] {
    case "retros" :: Retro(retro) :: "actions" :: Nil CRUDAction req if test(req) => retro
  } {
    (req, retro) => action(req, retro)
  }

}
