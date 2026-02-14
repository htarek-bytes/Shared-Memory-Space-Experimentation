#import "@preview/rubber-article:0.3.1": *
:
#import "@preview/colorful-boxes:1.4.2": *
#import "@preview/codly:1.2.0": *
#import "@preview/codly-languages:0.1.1": *

// Initialisation de Codly
#show: codly-init.with()

// Configuration pour éviter les débordements visuels
#show raw: set text(size: 9pt)

#let nonum(eq) = math.equation(block: true, numbering: none, eq)
#counter(math.equation).update(())
#show selector(heading.where(level: 4)) : set heading(numbering: none)

#show: article.with(
  show-header: true,
  header-titel: "T.H 202 301 89",
  eq-numbering: "(1.1)",
  eq-chapterwise: true,
)

#maketitle(
  title: "How does shared memory works anyway?",
  authors: ("Tarik Hireche : 202 301 89" ,),
  date: datetime.today().display("[day]. [month repr:long] [year]"),
)
#set text(size: 8pt)
#nonum( $ "Rapport écrit par Tarik Hireche" $)
#set text(size: 11pt)


= File descriptor... huh?

The OS uses a really clever trick called *Virtural File System (VFS)*. When we call ```C shm_open()```, Linux creates an object in a special temporary filesystem called tmpfs (tmp for temporary fs for file system).

This filesystem lives *ENTIRELY in RAM* (specifically, usually mounted at the path /dev/shm/).

The idea is that the OS *pretends* it is a file so that you and I can use standard, comfortable tools like File Descriptors, ftruncate, and permissions masks (0666). But hardware-wise, we are direclty maniulating RAM.


So the flow & idea is: We have this cool object we call tmpfs created by the kernel, it is a temporary file system that behaves like a file. Why the heck do we do that? It's just a vehicle for RAM, a standardized box that sits in ram and behaves like file. We can therefore use any file operations on it. (open, read, write, close).


