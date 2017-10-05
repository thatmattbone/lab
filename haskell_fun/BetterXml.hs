module BetterXml(Xml(..)) where

import qualified Data.Map as M
                

data Xml = XmlNode Name Namespace Attributes Children |
         Cdata Characters deriving Show

type Name = String
type Namespace = String
type Attributes = [(String, String)]
type Children = [Xml]
type Characters = String


type Xdo = M.Map String String


a = XmlNode "a" "mynamespace" [("attr1", "myval"), ("attr2", "myval")] []
b = XmlNode "b" "mynamespace" [] [a]

c = M.empty 