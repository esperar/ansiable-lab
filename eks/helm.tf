resource "helm_release" "aws_efs_csi_driver" {
    chart = "aws-efs-csi-driver"
    name = "aws-efs-csi-driver"
    namespace = "kube-system"
    repository = "https://kubernetes-sigs.github.io/aws-efs-csi-driver/"

    set {
        name = "image.repository"
        value = "eks drivier" # not yet
    }

    set {
        name = "controller.serviceAccount.create"
        value = true
    }

    set {
        name = "controller.serviceAccount.annotation.eks\\.amazonaws\\.com/role-arn"
        value = module.attach_efs_csi_role.iam_role_arn
    }

    set {
        name = "controller.serviceAccount.name"
        value = "efs-csi-controller-sa"
    }
}