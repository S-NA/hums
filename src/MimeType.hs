{-
    hums - The Haskell UPnP Server
    Copyright (C) 2009, 2012 Bardur Arantsson <bardur@scientician.net>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
-}

module MimeType ( guessMimeType
                , imageJpeg
                ) where

import Data.ByteString (ByteString)
import Data.ByteString.Char8 ()
import Data.Text (Text)
import Filesystem.Path (FilePath, extension)
import Prelude hiding (FilePath)

-- A primitive MIME type guesser. We use a custom one instead of the
-- relatively standard /etc/mime.types since UPnP media server clients
-- can be finicky about which MIME types they accept.
guessMimeType :: FilePath -> ByteString
guessMimeType fp =
    case extension fp of
      Nothing -> defaultMimeType
      Just ext -> mimeType ext
    where
      mimeType :: Text -> ByteString
      mimeType "xml"  = "text/xml"
      mimeType "avi"  = "video/divx"   -- PlayStation 3 oddity ('x-msvideo' is standard)
      mimeType "mp3"  = "audio/mpeg"
      mimeType "mpg"  = "video/mpeg"
      mimeType "m2ts" = "video/mpeg"
      mimeType "m2t"  = "video/mpeg"
      mimeType "jpg"  = imageJpeg
      mimeType "mp4"  = "video/mp4"
      mimeType _      = defaultMimeType
      defaultMimeType = "application/octet-stream"

-- JPEG image mime type
imageJpeg :: ByteString
imageJpeg = "image/jpeg"
