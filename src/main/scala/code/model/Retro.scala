package code.model

import net.liftweb.mapper._

object Retro extends Retro with LongKeyedMetaMapper[Retro] {

  override def dbTableName = "retro"

}

class Retro extends LongKeyedMapper[Retro] with IdPK {

  def getSingleton = Retro

  object title extends MappedString(this, 256)

}
