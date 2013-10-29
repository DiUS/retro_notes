package code
package snippet

import scala.xml.{NodeSeq, Text}
import net.liftweb.util._
import net.liftweb.common._
import java.util.Date
import code.lib._
import Helpers._

class Time {
  lazy val date: Box[Date] = DependencyFactory.inject[Date]

  /**
   * replace the contents of the element with id "time" with the date
   */
  def render = "#time *" #> date.map(_.toString)

}

