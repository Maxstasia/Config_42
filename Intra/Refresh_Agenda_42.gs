/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   Refresh_Agenda_42.gs                               :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mstasiak <mstasiak@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/01/13 15:15:12 by mstasiak          #+#    #+#             */
/*   Updated: 2025/01/13 16:29:04 by mstasiak         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

// Fonction qui synchronise l'agenda iCal avec Google Calendar
function syncICalToGoogleCalendar() {
	var iCalUrl = 'ton url iCal'; // Remplace 'ton url iCal' par l'URL de ton agenda iCal
	var calendarId = 'ton agenda ID'; // Remplace 'ton agenda ID' par l'ID de ton agenda ou par 'primary' pour mettre ton agenda personnel.

	var response = UrlFetchApp.fetch(iCalUrl);  // Récupère le contenu de l'URL iCal
	var eventsData = response.getContentText(); // Récupère le texte brut de l'agenda iCal

	// Parse l'agenda iCal et extrait les événements
	var icalEvents = parseICal(eventsData); 

	// Récupère ton Google Calendar
	var calendar = CalendarApp.getCalendarById(calendarId);

	// Récupère tous les événements existants dans Google Calendar
	var existingEvents = calendar.getEvents(new Date(), new Date(new Date().getFullYear() + 1, 0, 1));

	// Supprime les événements de Google Calendar qui ne sont pas dans iCal
	existingEvents.forEach(function(event) {
		var match = icalEvents.find(function(icalEvent) {
			return (
				event.getTitle() === icalEvent.title &&
				event.getStartTime().getTime() === icalEvent.start.getTime() &&
				event.getEndTime().getTime() === icalEvent.end.getTime() &&
				event.getDescription() === icalEvent.description &&
				event.getLocation() === icalEvent.location
			);
		});
		if (!match) {
			event.deleteEvent(); // Supprime l'événement s'il n'existe plus dans l'iCal
		}
	});

	// Ajoute ou met à jour les événements dans Google Calendar
	icalEvents.forEach(function(icalEvent) {
		if (!isEventDuplicate(calendar, icalEvent)) {
			calendar.createEvent(icalEvent.title, icalEvent.start, icalEvent.end, {
				description: icalEvent.description,
				location: icalEvent.location
			});
		}
	});
}

// Fonction pour vérifier si un événement existe déjà
function isEventDuplicate(calendar, newEvent) {
	var existingEvents = calendar.getEvents(newEvent.start, newEvent.end);

	for (var i = 0; i < existingEvents.length; i++) {
		var event = existingEvents[i];
		if (
			event.getTitle() === newEvent.title &&
			event.getStartTime().getTime() === newEvent.start.getTime() &&
			event.getEndTime().getTime() === newEvent.end.getTime() &&
			event.getDescription() === newEvent.description &&
			event.getLocation() === newEvent.location
		) {
			return true; // L'événement existe déjà
		}
	}
	return false; // L'événement n'existe pas
}

// Fonction pour parser le fichier iCal et extraire les événements
function parseICal(icalData) {
	var events = [];
	var regex = /BEGIN:VEVENT([\s\S]*?)END:VEVENT/g;
	var match;

	while (match = regex.exec(icalData)) {
		var eventContent = match[1];
		var title = /SUMMARY:(.*)/.exec(eventContent);
		var start = /DTSTART:(\d{8}T\d{6})/.exec(eventContent);
		var end = /DTEND:(\d{8}T\d{6})/.exec(eventContent);
		var description = /DESCRIPTION:(.*)/.exec(eventContent);
		var location = /LOCATION:(.*)/.exec(eventContent);

		if (title && start && end) {
			events.push({
				title: title[1],
				start: parseDate(start[1]),
				end: parseDate(end[1]),
				description: description ? description[1] : '',
				location: location ? location[1] : ''
			});
		}
	}
	return events;
}

// Fonction pour convertir les dates iCal au format JavaScript
function parseDate(icalDate) {
	var year = icalDate.substr(0, 4);
	var month = icalDate.substr(4, 2) - 1; 
	var day = icalDate.substr(6, 2);
	var hour = icalDate.substr(9, 2);
	var minute = icalDate.substr(11, 2);
	var second = icalDate.substr(13, 2);

	return new Date(year, month, day, hour, minute, second);
}
