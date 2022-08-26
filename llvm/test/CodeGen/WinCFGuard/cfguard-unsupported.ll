; RUN: llc < %s -mtriple=x86_64-linux-gnu
; Control Flow Guard is currently only available on Windows
; This test checks that the cfguard attribute does not crash on non-Windows
; target.

; This file was generated from the following source, using this command line:
; clang -target x86_64-linux-gnu cfguard-unsupported.c -S -emit-llvm -o cfguard-unsupported.ll -O -Xclang -cfguard
;-------------------------------------------------------------------------------
; extern void address_taken(void);
;
; void (*get_ptr(void))(void) {
;     return &address_taken;
; }
;
; void call_ptr(void (*p)(void)) {
;     p();
; }
;-------------------------------------------------------------------------------

; ModuleID = 'cfguard-unsupported.c'
source_filename = "cfguard-unsupported.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn uwtable
define dso_local nonnull ptr @get_ptr() local_unnamed_addr #0 {
  ret ptr @address_taken
}

declare void @address_taken() #1

; Function Attrs: nounwind uwtable
define dso_local void @call_ptr(ptr nocapture noundef readonly %0) local_unnamed_addr #2 {
  tail call void %0() #3
  ret void
}

attributes #0 = { mustprogress nofree norecurse nosync nounwind readnone willreturn uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nounwind uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 2, !"cfguard", i32 2}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"PIE Level", i32 2}
!4 = !{i32 7, !"uwtable", i32 2}
!5 = !{!"clang version 16.0.0"}
