.global main

// Entrées: entiers signés a et b de 16 bits
// Sortie:  a + b sur 32 bits, a + b déborde sur 16 bits?, a * b sur 32 bits
// Usage des registres:
//   x19 -- a     x22 -- i
//   x20 -- b     x23 -- acc
//   x21 -- c     x24 -- 2 (constante)
main:                               // main()
    // Lire a et b                  // {
    adr     x0, fmtEntree           //
    adr     x1, temp                //
    bl      scanf                   //   scanf("%hd", &temp)
    adr     x19, temp               //
    ldrsh   x19, [x19]              //   short a = temp
                                    //
    adr     x0, fmtEntree           //
    adr     x1, temp                //
    bl      scanf                   //   scanf("%hd", &temp)
    adr     x20, temp               //
    ldrsh   x20, [x20]              //   short b = temp
                                    //
    // Addition                     //
    add     w21, w19, w20           //   int c = a + b
                                    //
    adr     x0, fmtSortie           //
    mov     w1, w21                 //
    bl      printf                  //   printf("%d\n", c)
                                    //
    // Débordement?                 //
    cmp     w21, 32768              //
    b.ge    debordement             //
    cmp     w21, -32768             //
    b.lt    debordement             //   if (-32768 <= c < 32768) {
    adr     x0, msgSansDebordement  //     msg = msgSansDebordement
    b       afficher_debordement    //   }
debordement:                        //   else {
    adr     x0, msgDebordement      //     msg = msgDebordement
afficher_debordement:               //   }
    bl      printf                  //   printf(&msg)
                                    //
    // Multiplication               //
    mov     x22, 32                 //   i   = 32
    mov     x23, 0                  //   acc = 0  // Accumulateur du produit
    mov     x24, 2                  //
boucle:                             //
    cbz     x22, fin                //   while (i != 0) {
    tbz     x20, 0, prochain        //     if (b[0] == 1) {
    add     x23, x23, x19           //       acc += a
prochain:                           //     }
    add     x19, x19, x19           //     décaler a d'un bit vers la gauche
    udiv    x20, x20, x24           //     décaler b d'un bit vers la droite
    sub     x22, x22, 1             //     i--
    b       boucle                  //   }
fin:                                //
    adr     x0, fmtSortie           //
    mov     w1, w23                 //
    bl      printf                  //   printf("%d\n", acc)
                                    //
    // Quitter                      //
    mov     x0, 0                   //
    bl      exit                    //   exit(0)
                                    // }
.section ".rodata"
fmtEntree:          .asciz  "%hd"
fmtSortie:          .asciz  "%d\n"
msgDebordement:     .asciz  "débordement\n"
msgSansDebordement: .asciz  "sans débordement\n"

.section ".bss"
temp:       .skip   2
