// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)


import { Application } from "@hotwired/stimulus"
//import ProgressStarsController from "./progress_stars_controller"

//const application = Application.start()

