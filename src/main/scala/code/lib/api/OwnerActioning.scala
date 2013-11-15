package code.lib.api

import net.liftweb.http.Req
import net.liftweb.common.{Empty, Failure, Full, BoxOrRaw}
import BoxOrRaw._

trait OwnerActioning {

  protected def ownerAction[O, T](testPF: PartialFunction[Req, BoxOrRaw[O]])(action:(Req, O) => BoxOrRaw[T]): PartialFunction[Req, BoxOrRaw[T]] = {
    case req: Req if testPF.isDefinedAt(req) => ownedAction[O, T](req, testPF)(action)
  }

  private def ownedAction[O, T](req: Req, pf: PartialFunction[Req, BoxOrRaw[O]])(action:(Req, O) => BoxOrRaw[T]): BoxOrRaw[T] = {
    pf(req).box match {
      case Full(owner) => action(req, owner)
      case Failure(msg, e, chain) => Failure(msg, e, chain)
      case _ => Empty
    }
  }

}
