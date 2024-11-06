module Web.FrontController where
import Web.View.Prelude
import IHP.RouterPrelude
import IHP.ControllerSupport
import Generated.Types
import Web.Types
import Web.View.Layout (defaultLayout)

-- Controller Imports
import Web.Controller.BenchWeb
import IHP.Welcome.Controller

instance FrontController WebApplication where
    controllers = 
        [ parseRoute @BenchWebController
        -- Generator Marker
        ]

instance InitControllerContext WebApplication where
    initContext = do
        setLayout defaultLayout
