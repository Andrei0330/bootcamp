const cds = require('@sap/cds');

class HelpdeskService extends cds.ApplicationService {
  init() {
    const { Tickets, Comments, Agents } = this.entities;
    const { SELECT, UPDATE, INSERT } = cds.ql;

    // ---- Validation: new tickets need a category and a subject ----
    this.before('CREATE', 'Tickets', (req) => {

      if (!req.data.category_ID) {
        req.error(400, 'Category is required', 'category_ID');
      }

      if (!req.data.subject) {
        req.error(400, 'Subject is required', 'subject');
      }

    });

    // ---- Structured error: block updates that try to "re-close" a closed ticket ----
    this.before('UPDATE', 'Tickets', async (req) => {

      if (req.data.status === 'CLOSED') {

        const ticket = await SELECT.one
          .from(Tickets, req.data.ID)
          .columns('status');

        if (ticket?.status === 'CLOSED') {
          req.error({
            code: 'ALREADY_CLOSED',
            message: 'Ticket is already closed',
            target: 'status'
          });
        }
      }

    });

    // ---- Custom action: closeTicket ----
    this.on('closeTicket', 'Tickets', async (req) => {

      const { ID } = req.params[0];
      const { resolution } = req.data;

      // TODO 1
      if (!resolution) {
        return req.error(400, 'Resolution is required', 'resolution');
      }

      // TODO 2
      const ticket = await SELECT.one
        .from(Tickets, ID)
        .columns('status');

      if (!ticket) {
        return req.error(404, 'Ticket not found');
      }

      // TODO 3
      if (ticket.status === 'CLOSED') {
        return req.error({
          code: 'ALREADY_CLOSED',
          message: 'Ticket is already closed',
          target: 'status'
        });
      }

      // TODO 4
      await UPDATE(Tickets, ID).set({
        status: 'CLOSED'
      });

      // TODO 5
      await INSERT.into(Comments).entries({
        text: `Ticket closed: ${resolution}`,
        ticket_ID: ID
      });

      // TODO 6
      return await SELECT.one.from(Tickets, ID);

    });

    // ---- Custom action: reassignTicket ----
    this.on('reassignTicket', 'Tickets', async (req) => {

      const { ID } = req.params[0];
      const { agentID } = req.data;

      // TODO 1
      if (!agentID) {
        return req.error(400, 'agentID is required', 'agentID');
      }

      // TODO 2
      const agent = await SELECT.one.from(Agents, agentID);

      if (!agent) {
        return req.error(404, 'Agent not found');
      }

      // TODO 3
      await UPDATE(Tickets, ID).set({
        agent_ID: agentID
      });

      // TODO 4
      return await SELECT.one.from(Tickets, ID);

    });

    // ---- Custom function: getTicketCount ----
    this.on('getTicketCount', async (req) => {

      const { status } = req.data;

      let tickets;

      if (status) {
        tickets = await SELECT
          .from(Tickets)
          .where({ status });
      } else {
        tickets = await SELECT.from(Tickets);
      }

      return tickets.length;

    });

    // ---- after CREATE: log new tickets ----
    this.after('CREATE', 'Tickets', (ticket) => {

      console.log(
        `[HelpdeskService] Ticket created: ${ticket.ticketNumber ?? ticket.ID}`
      );

    });

    return super.init();
  }
}

module.exports = HelpdeskService;