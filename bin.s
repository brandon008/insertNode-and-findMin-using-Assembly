
// All assembly code to be inserted here.

	// Uncomment these three lines:
 	 .section	__TEXT,__text,regular,pure_instructions
 	 .globl	_insert_node
     .p2align	4, 0x90


// WRITE THE FUNCTION insert_node THAT OPERATES THE SAME AS
// THE COMMENTED-OUT C CODE BELOW.


# // This function inserts a new NODE into the binary search
# // tree in the appropriate position.



# // void insert_node(NODE *new_n)
# // {

# //   // If the tree is empty, then set root to
# //   // point to the new node.
   # if (root == NULL) {
   #   root = new_n;
   #   return;
   # }



# _root(%rip) = root
# rdi = new_n
# rcx = p
# r8 = res lastnames


# first param of a function in assembly is RDI, second is RSI ]
# after cmp ALWAYS jump
# return value in any function is always movq %rax or %eax
# all variables in n
# whenever a function is called you need to pushq all the caller saved registers that you used, after the function call you pop them 
_insert_node:

        pushq   %rbp
        pushq	%r12
        movq    %rsp, %rbp


        # movq _root(%rip), %rcx
        # cmpq $0, %rcx	    # compare root equals null (root == null)
        cmpq $0, _root(%rip)

        jne	NOT_NULL				# if its not null... 
        movq %rdi, _root(%rip)
        jmp DONE1

 NOT_NULL:

 		movq _root(%rip), %rcx 		# setting p = root

 WHILE:
 		movq 0(%rdi), %r12
 		cmpq 0(%rcx), %r12			# if (new_n->person.id == p->person.id)
 		je DONE1					   # break 


 		pushq %rdi					#pushing all caller saved 
 		pushq %rcx
 		pushq %r8
 		leaq 116(%rdi), %rdi 		#last name 
 		leaq 116(%rcx), %rsi
 		call _strcmp				#FUNCTION res will be in RAX
 		popq %r8
 		popq %rcx 					#popping
 		popq %rdi	
 		movq %rax, %r8				# setting r8 = res lastnames

 		cmpq $0, %r8					# if (new_n->person.last == p->person.last)
 		jne RES_LESS

 		pushq %rcx					#pushing all caller saved 
 		pushq %rdi
 		pushq %r8
 		leaq 16(%rdi), %rdi 		#first name
 		leaq 16(%rcx), %rsi
 		call _strcmp				#FUNCTION res(firstnme) will be in RAX
		popq %r8
		popq %rdi 					#popping
		popq %rcx	
		movq %rax, %r8				#whatever value was last overwritten USE
 RES_LESS:
 		cmpq $0, %r8				# if (res < 0) {
 		jge ELSE_RIGHT							


		cmpq $0, 216(%rcx)			#if (p->left == NULL)
		jne ELSE_LEFT
		movq %rdi, 216(%rcx) 		# p->left = new_n;
		jmp DONE1

 ELSE_LEFT:
 		movq 216(%rcx), %rcx  		# p = p->left;
 		jmp WHILE

 ELSE_RIGHT:

		cmpq $0, 224(%rcx) 			# if (p->right == NULL)
		jne ELSE_3
		movq %rdi, 224(%rcx)		# p->right = new_n;
		jmp DONE1
ELSE_3:
		movq 224(%rcx), %rcx		# p = p->right
		jmp WHILE
DONE1:
	
		popq %r12
		popq %rbp
		ret



# //   // p will be used to traverse the tree to find
# //   // the place to insert the new node.

# //   NODE *p = root;

# //   // The tree traversal is in an infinite loop, which
# //   // we will "break" out from when the traversal
# //   // is done.

# //   while(1) {

# //   // If a person with the same id is enountered,
# //   // then break out of the loop (rather than insert
# //   // a redundant employee record).

# //     if (new_n->person.id == p->person.id) {
# //       break;
# //     }

# //     // Compare the last name in the new node with the
# //     // last name in the current node (i.e. the node
# //     // pointed to by p).

# //     int res = strcmp(new_n->person.last, p->person.last);

# //     // If the two last names are the same, then compare the
# //     // first names.

# //     if (res == 0)
# //       res = strcmp(new_n->person.first, p->person.first);

# //     // At this point, res < 0 indicates that the new node
# //     // comes before (alphabetically) the current node, and
# //     // thus must inserted into the left subtree of p.

# //     if (res < 0) { //1

# //       // If p does not have a left child, then new node
# //       // becomes the left child.

# //       if (p->left == NULL) { //2
# // 			p->left = new_n;
# // 			break;
# //       }
# //       else // left {

# // 	// otherwise, traverse down the left subtree.

# // 			p = p->left;
# //       }
# //     }

# //     // Otherwise, if res >= 0, the new node goes in the
# //     // right subtree.

# //     else { //right

# //       // If p does not have a right child, then new node
# //       // becomes the right child.

# //       if (p->right == NULL) { //3
# // 			p->right = new_n;
# // 			break;
# //       }
# //       else //3 {

# // 	// otherwise, traverse down the right subtree.

# // 			p = p->right;
# //       }
# //     }
# //   }
# // }

# rdx = parent

	// Uncomment these three lines:
	 .section	__TEXT,__text,regular,pure_instructions
	 .globl	_remove_smallest
	 .p2align	4, 0x90


// WRITE THE FUNCTION remove_smallest THAT OPERATES THE SAME AS
// THE COMMENTED-OUT C CODE BELOW.

#r12 = root
#rcx = p
#rdx = parent

_remove_smallest:
        pushq   %rbp
        pushq	%r12
        movq    %rsp, %rbp

        cmpq $0, _root(%rip)		# if (root == NULL) {
        jne	NOT_NULL2				#
        movq $0, %rax 				# return NULL
        jmp DONE

NOT_NULL2:
		movq _root(%rip), %r12 		#
		cmpq $0, 216(%r12) 			# if (root->left == NULL)
		jne SET_NODE				#
		movq _root(%rip), %rcx				# NODE *p = root;
		movq 224(%r12), %rdi 		# root = root->right;
		movq %rdi, _root(%rip)
		movq %rcx, %rax 			# return p;
		jmp DONE 					#

SET_NODE:
		movq _root(%rip), %rdx 			# NODE *parent = root;


WHILE2:
		movq 216(%rdx),	%r9
		movq 216(%r9), %r9
		cmpq $0, %r9 				# condition (parent->left-left != null)
		je AFTER_WHILE2
		movq 216(%rdx), %rdx		# parent = parent->left;
		jmp WHILE2

AFTER_WHILE2:
		movq 216(%rdx), %rcx		# NODE *p = parent->left;
		movq 216(%rdx),	%r8
		movq 224(%r8), %r8
		movq %r8, 216(%rdx)						# parent->left = parent->left->right;
		movq %rcx, %rax				# return p
		jmp DONE

DONE:
		popq %r12
		popq %rbp
		ret

// This function removes the smallest node from the binary
// search tree. That is, it removes the node representing
// the employee whose name comes before (alphabetically) the
// other employees in the tree. The function returns
// a pointer to the node that has been returned.

// NODE *remove_smallest()
// {

//   // If the tree is already empty, return NULL.

//   if (root == NULL) {
//     return NULL;
//   } 

//   // If there is no left child of the root, then the smallest
//   // node is the root node. Set root to point to its right child
//   // and return the old root node.

//   if (root->left == NULL) { //not null 2
//     NODE *p = root;
//     root = root->right;
//     return p;
//   }

//   // At this point, we know that root has a left child,
//   // i.e. that root->left is not NULL. We'll need to
//   // keep track of the parent of the node that we're
//   // eventually removing, so we use a "parent" pointer
//   // for that purpose.

//   NODE *parent = root;

//   // Traverse down the left side of the tree until we
//   // hit a node that doesn't have a left child.  Again,
//   // our "parent" pointer points to the parent of
//   // such a node.

//   while (parent->left->left != NULL) {
//     parent = parent->left;
//   }

//   // At this point, parent->left points to the node with
//   // the smallest value (alphabetically).  So, we are
//   // going to set parent->left to parent->left->right,
//   // and return the old parent->left.

//   NODE *p = parent->left;
//   parent->left = parent->left->right;
//   return p;
// }
