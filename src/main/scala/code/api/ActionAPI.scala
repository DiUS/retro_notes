package code.api

import code.model.{Retro, Action}
import net.liftweb.http._
import Action._
import net.liftweb.mapper.By
import code.lib.api.{JxConversions, RetroOwnerActioning}

object ActionAPI extends JxConversions[Action] with RetroOwnerActioning {

  type ONE = Action
  type MANY = List[ONE]

  serveJx[ONE] {
    case "actions" :: Action(action) :: Nil RUAction req => req.requestType match {
      case PutRequest => update(action, req) map saved
      case _          => action
    }
  }

  serveJx[ONE] {
    retroAction[ONE](_.post_?) {
      (req, retro) => create[Retro](retro, req) map saved
    }
  }

  serveJx[Boolean] {
    case "actions" :: Action(action) :: Nil Delete req => {
      delete(action) ?~ "Failed to delete action"
    }
  }

  serveJx[MANY] {
    retroAction[MANY](_.get_?) {
      (req, retro) => findAll(By(Action.retro, retro))
    }
  }

}
