# Mermaid Diagrams

This page contains several Mermaid diagrams demonstrating different character sets.

## English Diagram

```mermaid
flowchart LR
    A[Start] --> B[Process Data]
    B --> C{Decision}
    C -->|Yes| D[Continue]
    C -->|No| E[Stop]
    D --> F[End]
    E --> F
```

## Ukrainian Diagram

```mermaid
flowchart TD
    A[Початок] --> B[Обробка даних]
    B --> C{Перевірка}
    C -->|Так| D[Продовжити]
    C -->|Ні| E[Зупинити]
    D --> F[Кінець]
    E --> F
```

## Emoji Diagram

```mermaid
flowchart LR
    A[🚀 Launch] --> B[⚙️ Process]
    B --> C{✅ Valid?}
    C -->|👍| D[💾 Save]
    C -->|👎| E[🗑️ Discard]
    D --> F[🎉 Done]
    E --> F
```

## Special Unicode Character Diagram (Right Click ➜)

```mermaid
flowchart LR
    A[Select Item] --> B[➜ Right Click]
    B --> C[Context Menu]
    C --> D[Choose Option]
    D --> E[➜ Execute Action]
```
