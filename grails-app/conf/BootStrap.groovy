import co.bugu.Task

class BootStrap {

    def init = { servletContext ->


        def task = new Task(event: "goodday")

        task.save();
    }
    def destroy = {
    }
}
