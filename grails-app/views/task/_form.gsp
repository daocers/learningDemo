<%@ page import="co.bugu.Task" %>



<div class="fieldcontain ${hasErrors(bean: taskInstance, field: 'event', 'error')} ">
	<label for="event">
		<g:message code="task.event.label" default="Event" />
		
	</label>
	<g:textField name="event" value="${taskInstance?.event}"/>
</div>

