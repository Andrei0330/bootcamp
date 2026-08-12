using Catalog as service from '../../srv/catalog-service';
annotate service.Tickets with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'Ticket Number',
                Value : ticketNumber,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Subject',
                Value : subject,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Description',
                Value : description,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Status',
                Value : status,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Priority',
                Value : priority,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Ticket Comments',
            ID : 'TicketComments',
            Target : 'comments/@UI.LineItem#TicketComments',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'Ticket Number',
            Value : ticketNumber,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Subject',
            Value : subject,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Description',
            Value : description,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Status',
            Value : status,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Priority',
            Value : priority,
        },
        {
            $Type : 'UI.DataField',
            Value : agent.name,
            Label : 'Assignee',
        },
    ],
    UI.SelectionFields : [
        status,
        priority,
        category.name,
        agent.name,
    ],
    UI.FieldGroup #TicketComments : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : comments.ticket.ID,
                Label : 'ID',
            },
            {
                $Type : 'UI.DataField',
                Value : comments.ticket.createdAt,
            },
            {
                $Type : 'UI.DataField',
                Value : comments.ticket.description,
                Label : 'description',
            },
        ],
    },
);

annotate service.Tickets with {
    category @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Categories',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : category_ID,
                ValueListProperty : 'ID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'name',
            },
        ],
    }
};

annotate service.Tickets with {
    agent @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Agents',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : agent_ID,
                ValueListProperty : 'ID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'name',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'email',
            },
        ],
    }
};
    annotate service.Tickets with {
    ticketNumber @Common.Label : 'Ticket Number';
    subject      @Common.Label : 'Subject';
    status       @Common.Label : 'Status';
    priority     @Common.Label : 'Priority';
    category     @Common.Label : 'Category';
    agent        @Common.Label : 'Assigned Agent';
};

    annotate service.Tickets with @(

    UI.HeaderInfo : {
        TypeName : 'Ticket',
        TypeNamePlural : 'Tickets',
        Title : {
            Value : ticketNumber
        },
        Description : {
            Value : subject
        }
    }

);


annotate service.Categories with {
    ID @(
        Common.Label : 'Category',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Categories',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : ID,
                    ValueListProperty : 'ID',
                },
            ],
            Label : 'Category',
        },
        Common.ValueListWithFixedValues : true,
        Common.Text : name,
    )
};

annotate service.Agents with {
    ID @(
        Common.Label : 'Assigned Agent',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Agents',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : ID,
                    ValueListProperty : 'ID',
                },
            ],
            Label : 'Agent',
        },
        Common.ValueListWithFixedValues : true,
        Common.Text : name,
    )
};

annotate service.Comments with @(
    UI.LineItem #TicketComments : [
        {
            $Type : 'UI.DataField',
            Value : ticket.ticketNumber,
        },
        {
            $Type : 'UI.DataField',
            Value : ticket.createdAt,
            Label : 'Created At',
        },
        {
            $Type : 'UI.DataField',
            Value : ticket.description,
            Label : 'Comments',
        },
    ]
);

annotate service.Agents with {
    name @(
        Common.Label : 'Assigned Agent',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Agents',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : name,
                    ValueListProperty : 'name',
                },
            ],
            Label : 'Agents',
        },
        Common.ValueListWithFixedValues : true,
        Common.Text : email,
    )
};

annotate service.Categories with {
    name @(
        Common.Label : 'Category',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Categories',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : name,
                    ValueListProperty : 'name',
                },
            ],
            Label : 'Category',
        },
        Common.ValueListWithFixedValues : true,
    )
};

