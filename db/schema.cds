namespace bootcamp.helpdesk;

using { 
    cuid,
    managed
 } from '@sap/cds/common';

type Email : String(20);

entity Categories : cuid, managed {
    name : String(100);
}

entity Agents : cuid, managed {
    name : String(100);
    email : Email;
}

type TicketStatus : String enum{
     open = 'OPEN';
     inProgress = 'IN_PROGRESS';
     resolved = 'RESOLVED';
     closed = 'CLOSED';
};

type Priority : String enum{
    low = 'LOW';
    medium = 'MEDIUM';
    high = 'HIGH';
    urgent = 'URGENT';
};

entity Tickets : cuid, managed {
    ticketNumber : Integer;
    subject : String(100);
    description : LargeString;
    status : TicketStatus;
    priority : Priority;
    category : Association to Categories;
    agent : Association to Agents;
    comments : Composition of many Comments
                on comments.ticket = $self;
};

entity Comments : cuid, managed {
    text : String(255);
    ticket : Association to Tickets;
}
