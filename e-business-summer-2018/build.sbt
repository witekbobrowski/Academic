name := "app"
version := "0.1.0"

libraryDependencies ++= Seq(
  "com.typesafe.slick" %% "slick" % "3.2.1",
  "org.slf4j" % "slf4j-nop" % "1.6.4",
  "com.typesafe.slick" %% "slick-hikaricp" % "3.2.1",
  "com.typesafe.play" %% "play" % "2.6.12",
  "mysql" % "mysql-connector-java" % "6.0.6"
)

libraryDependencies ++= Seq(
  "org.scalatest" %% "scalatest"                   % "3.0.1" % Test
)
