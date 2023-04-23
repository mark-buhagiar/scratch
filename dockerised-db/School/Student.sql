CREATE TABLE [dbo].[Student] (
    [Id]        INT NOT NULL PRIMARY KEY CLUSTERED ([Id] ASC),
    [TeacherId] INT NULL,
    CONSTRAINT [FK_Student_Teacher] FOREIGN KEY ([TeacherId]) REFERENCES [dbo].[Teacher] ([Id])
);
