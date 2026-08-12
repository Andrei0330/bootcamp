sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"bootcamphelpdesk/bootcamphelpdesklist/test/integration/pages/TicketsList.gen",
	"bootcamphelpdesk/bootcamphelpdesklist/test/integration/pages/TicketsObjectPage.gen"
], function (JourneyRunner, TicketsListGenerated, TicketsObjectPageGenerated) {
    'use strict';

    const runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('bootcamphelpdesk/bootcamphelpdesklist') + '/test/flp.html#app-preview',
        pages: {
			onTheTicketsListGenerated: TicketsListGenerated,
			onTheTicketsObjectPageGenerated: TicketsObjectPageGenerated
        },
        async: true
    });

    return runner;
});

