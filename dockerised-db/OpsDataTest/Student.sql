CREATE TABLE [dbo].[DeliveryParcel] (
    [Id]         INT           IDENTITY (1, 1) NOT NULL PRIMARY KEY CLUSTERED ([Id] ASC),
    [Name]       NVARCHAR (50) NULL,
    [TradeLegId] INT           NULL,
    CONSTRAINT [FK_DeliveryParcel_TradeLeg] FOREIGN KEY ([TradeLegId]) REFERENCES [dbo].[TradeLeg] ([Id])
);
