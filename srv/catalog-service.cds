using { bootcamp.helpdesk as db } from '../db/schema';

service Catalog {

    entity Categories as projection on db.Categories;

    entity Agents as projection on db.Agents;

    entity Comments as projection on db.Comments;

    entity Tickets as projection on db.Tickets
        actions {

            action closeTicket(
                resolution : String
            );

            action reassignTicket(
                agentID : UUID
            );
        };

    function getTicketCount(
        status : String
    ) returns Integer;
}