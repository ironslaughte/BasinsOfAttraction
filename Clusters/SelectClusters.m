function anotherClusters = SelectClusters(Clusters, currCluster)
anotherClusters = [];
for j = 1:length(Clusters(:,4))
    flag = true;
    for i = 1:currCluster
        if(Clusters(j,4) == i)
            flag = false;
            break;
        end
    end
    if(flag)
        anotherClusters = cat(1,anotherClusters, Clusters(j,:));
    end
end
end